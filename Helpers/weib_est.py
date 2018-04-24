import csv
import math
import numpy as np

class Weib:

    def estimate(self, data):

        print("Hello!")

    def loglikelihood(self, a, b, source_data):

        weight = len(source_data)

        pow_gam_ln_sum = 0

        ln_sum = 0

        for val in source_data:

            pow_gam_ln_sum = pow_gam_ln_sum + ((val / a)**b)

            ln_sum = ln_sum + math.log(val)

        return weight * (math.log(b) - b * math.log(a)) - pow_gam_ln_sum + (b - 1) * ln_sum

    def loglikelihoodOpt(self, beta, gamma, source_data):

        weight = len(source_data)

        xi_pow_gamma_ln_sum = 0

        ln_sum = 0

        xi_pow_gamma_sum = 0

        for val in source_data:

            log_val = math.log(val)

            pow_gam_val = val**gamma

            ln_sum += log_val

            xi_pow_gamma_sum += pow_gam_val

            xi_pow_gamma_ln_sum += log_val * pow_gam_val

        return (1 / gamma) + (ln_sum / weight) - (xi_pow_gamma_ln_sum / xi_pow_gamma_sum)

    def gradient(self):

        def g1(a, b, data):

            pow_gam_sum = 0

            for val in data:

                pow_gam_sum += (val / a)**b

            return (pow_gam_sum - len(data)) * (b / a)

        def g2(a, b, data):

            pow_gamma_ln_sum = 0

            ln_sum = 0

            for val in data:

                pow_gamma_ln_sum += ((val / a)**b) * math.log(val / a)

                ln_sum += math.log(val)

            return len(data) * ((1 / b) - math.log(a)) - pow_gamma_ln_sum + ln_sum

        return [g1, g2]

    def hessian(self):

        def h11(a, b, data):

            pow_gam_sum = 0

            for val in data:

                pow_gam_sum += (val / a) ** b

            return (len(data) - (b + 1) * pow_gam_sum) * (b / (a**2))

        def h12(a, b, data):

            pow_gam_sum = 0

            pow_gamma_ln_sum = 0

            for val in data:

                pow_gam_val = (val / a)**b

                pow_gam_sum += pow_gam_val

                pow_gamma_ln_sum += pow_gam_val * math.log(val / a)

            return (-len(data) + pow_gam_sum + b * pow_gamma_ln_sum) / a

        h21 = h12

        def h22(a, b, data):

            pow_gamma_ln2_sum = 0

            for val in data:

                pow_gamma_ln2_sum += ((val / a)**b) * (math.log(val / a)**2)

            return -(len(data) / (b**2)) - pow_gamma_ln2_sum

        return [[h11, h12], [h21, h22]]


def optimization_case():

    file = open('../../csv_data/AQI.csv')

    data_iter = csv.reader(file)

    aqi_data = []

    next(data_iter)     # Skip header.

    for row in data_iter:

        aqi_data.append(float(row[0]))

    weib = Weib()

    x = np.array([[70], [2]])

    gradient = weib.gradient()

    hessian_mat = weib.hessian()

    gradient_val = np.array([[gradient[0](x[0, 0], x[1, 0], aqi_data)], [
                            gradient[1](x[0, 0], x[1, 0], aqi_data)]])

    hessian_val = np.array([
        [hessian_mat[0][0](x[0, 0], x[1, 0], aqi_data),
         hessian_mat[0][1](x[0, 0], x[1, 0], aqi_data)],
        [hessian_mat[1][0](x[0, 0], x[1, 0], aqi_data), hessian_mat[1][1](x[0, 0], x[1, 0], aqi_data)]])

    hessian_inv_val = np.linalg.inv(hessian_val)

    delta_x = np.matmul(hessian_inv_val, gradient_val)

    xn = x - delta_x

    llv = weib.loglikelihood(x[0, 0], x[1, 0], aqi_data)

    llv_next = weib.loglikelihood(xn[0, 0], xn[1, 0], aqi_data)

    step_size = 1

    while llv_next < llv:

        step_size /= 2.0

        xn = x - step_size * delta_x

        llv_next = weib.loglikelihood(xn[0, 0], xn[1, 0], aqi_data)

    iteration = 1

    print("Iteration: %d, LLVN: %f, Step Size: %f" %
          (iteration, llv_next, step_size))
    # print("Gra: ", gradient_val.flatten(), ", H: ", hessian_inv_val.flatten())
    # print("X(k+1): ", xn.flatten())

    # while math.fabs(gradient_val[0, 0]) > 10e-14 or math.fabs(gradient[1, 0]) > 10e-14:
    while iteration < 20:

        iteration += 1

        x = xn

        llv = llv_next

        step_size = 1

        gradient_val = np.array([[gradient[0](x[0, 0], x[1, 0], aqi_data)], [
                                gradient[1](x[0, 0], x[1, 0], aqi_data)]])

        hessian_val = np.array([
            [hessian_mat[0][0](x[0, 0], x[1, 0], aqi_data),
             hessian_mat[0][1](x[0, 0], x[1, 0], aqi_data)],
            [hessian_mat[1][0](x[0, 0], x[1, 0], aqi_data), hessian_mat[1][1](x[0, 0], x[1, 0], aqi_data)]])

        hessian_inv_val = np.linalg.inv(hessian_val)

        delta_x = np.matmul(hessian_inv_val, gradient_val)

        xn = x - delta_x

        llv_next = weib.loglikelihood(xn[0, 0], xn[1, 0], aqi_data)

        step_size = 1

        while llv_next < llv:

            step_size /= 2.0

            xn = x - step_size * delta_x

            llv_next = weib.loglikelihood(xn[0, 0], xn[1, 0], aqi_data)

        print("Iteration: %d, LLVN: %lf, Step Size: %lf" %
              (iteration, llv_next, step_size))
        print("Gra: ", gradient_val.flatten(),
              ", H: ", hessian_inv_val.flatten())
        print("X(k+1): ", xn.flatten())

    print(xn)

def bfgs_case():

    file = open('../../csv_data/AQI.csv')

    data_iter = csv.reader(file)

    aqi_data = []

    next(data_iter)     # Skip header.

    for row in data_iter:

        aqi_data.append(float(row[0]))

    weib = Weib()

    # Start BFGS.
    gradient_fun = weib.gradient()

    thetak_m1 = np.array([[1], [1]])

    gk_m1 = np.array([[gradient_fun[0](thetak_m1[0, 0], thetak_m1[1, 0], aqi_data)], [gradient_fun[1](thetak_m1[0, 0], thetak_m1[1, 0], aqi_data)]])

    bk_m1 = np.array([[1, 0], [0, 1]])

    delta_theta = np.matmul(np.linalg.inv(bk_m1), gk_m1)

    llv = weib.loglikelihood(thetak_m1[0, 0], thetak_m1[1, 0], aqi_data)

    thetak = thetak_m1 - delta_theta

    llvn = weib.loglikelihood(thetak[0, 0], thetak[1, 0], aqi_data)

    print(llvn)

# optimization_case()

bfgs_case()