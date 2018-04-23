require 'csv'
require 'matrix'

module NewtonRaphson
end

module Weib
    def self.estimate(data)
        puts "Hello!"
    end

    def self.loglikelihood(a, b, source_data)
        
        weight = source_data.length

        pow_gam_ln_sum = 0

        ln_sum = 0

        source_data.each {|val|

            pow_gam_ln_sum = pow_gam_ln_sum + ((val / a)**b)

            ln_sum = ln_sum + Math.log(val)

        }

        weight * (Math.log(b) - b * Math.log(a)) - pow_gam_ln_sum + (b - 1) * ln_sum

    end

    def self.loglikelihoodOpt(beta, gamma, source_data)

        weight = source_data.length

        xi_pow_gamma_ln_sum = 0

        ln_sum = 0

        xi_pow_gamma_sum = 0

        source_data.each do |val|

            log_val =  Math.log(val)

            pow_gam_val = val**gamma

            ln_sum += log_val

            xi_pow_gamma_sum += pow_gam_val

            xi_pow_gamma_ln_sum += log_val * pow_gam_val

        end

        (1 / gamma) + (ln_sum / weight) - (xi_pow_gamma_ln_sum / xi_pow_gamma_sum)
    end

    def self.gradient

        g1 = ->(a, b, data) {

            pow_gam_sum = 0

            data.each do |val|

                pow_gam_sum += (val / a)**b

            end
            
            (pow_gam_sum - data.length) * (b / a)

        }

        g2 = ->(a, b, data) {

            pow_gamma_ln_sum = 0

            ln_sum = 0

            data.each { |val|

                pow_gamma_ln_sum += ((val / a)**b) * Math.log(val / a)

                ln_sum += Math.log(val)

            }

            data.length * ((1 / b) - Math.log(a)) - pow_gamma_ln_sum + ln_sum

        }

        [g1, g2]

    end

    def self.hessian

        h11 = ->(a, b, data){

            pow_gam_sum = 0

            data.each {|val|

                pow_gam_sum += (val / a) ** b

            }

            (data.length - (b + 1) * pow_gam_sum) * (b / (a**2))

        }

        h12 = ->(a, b, data){

            pow_gam_sum = 0

            pow_gamma_ln_sum = 0

            data.each {|val|

                pow_gam_val = (val / a)**b

                pow_gam_sum += pow_gam_val

                pow_gamma_ln_sum += pow_gam_val * Math.log(val / a)

            }

            (-data.length + pow_gam_sum + b * pow_gamma_ln_sum) / a

        }

        h21 = h12

        h22 = ->(a, b, data){

            pow_gamma_ln2_sum = 0

            data.each {|val|

                pow_gamma_ln2_sum += ((val / a)**b) * (Math.log(val / a)**2)

            }

            -(data.length / (b**2)) - pow_gamma_ln2_sum

        }

        [[h11, h12], [h21, h22]]

    end
end

data_table = CSV.read("../../csv_data/AQI.csv")

aqi_data = []

1.upto(data_table.length - 1) do |row|

    aqi_data << data_table[row][0].to_f

end

# Weib.estimate aqi_data
# print Weib.loglikelihoodOpt 1, 1, aqi_data

x = Matrix.column_vector([1, 1])

gradient = Weib.gradient

hessian_mat = Weib.hessian

gradient_val = Matrix.column_vector([gradient[0].call(x[0, 0], x[1, 0], aqi_data), gradient[1].call(x[0, 0], x[1, 0], aqi_data)])

hessian_val = Matrix[
    [hessian_mat[0][0].call(x[0, 0], x[1, 0], aqi_data), hessian_mat[0][1].call(x[0, 0], x[1, 0], aqi_data)],
    [hessian_mat[1][0].call(x[0, 0], x[1, 0], aqi_data), hessian_mat[1][1].call(x[0, 0], x[1, 0], aqi_data)]]

hessian_inv_val = hessian_val.inv

delta_x = hessian_inv_val * gradient_val

xn = x - delta_x

llv = Weib.loglikelihood(x[0, 0], x[1, 0], aqi_data)

llv_next = Weib.loglikelihood(xn[0, 0], xn[1, 0], aqi_data)

step_size = 1

while llv_next < llv do

    step_size /= 2

    xn = x - step_size * delta_x

    llv_next = Weib.loglikelihood(xn[0, 0], xn[1, 0], aqi_data)

end

iteration = 1

puts "Iteration: #{iteration}, LLVN: #{llv_next}"
puts "Gra: #{gradient_val}, H: #{hessian_val}"
puts "X(k+1): #{xn}"

while iteration < 15 do 

    iteration += 1

    x = xn

    llv = llv_next 

    step_size = 1

    gradient_val = Matrix.column_vector([gradient[0].call(x[0, 0], x[1, 0], aqi_data), gradient[1].call(x[0, 0], x[1, 0], aqi_data)])

    hessian_val = Matrix[
        [hessian_mat[0][0].call(x[0, 0], x[1, 0], aqi_data), hessian_mat[0][1].call(x[0, 0], x[1, 0], aqi_data)],
        [hessian_mat[1][0].call(x[0, 0], x[1, 0], aqi_data), hessian_mat[1][1].call(x[0, 0], x[1, 0], aqi_data)]]

    hessian_inv_val = hessian_val.inv

    delta_x = hessian_inv_val * gradient_val

    xn = x - delta_x

    llv_next = Weib.loglikelihood(xn[0, 0], xn[1, 0], aqi_data)

    step_size = 1

    while llv_next < llv do

        step_size /= 2

        xn = x - step_size * delta_x

        llv_next = Weib.loglikelihood(xn[0, 0], xn[1, 0], aqi_data)

    end

    puts "Iteration: #{iteration}, LLVN: #{llv_next}"
    puts "Gra: #{gradient_val}, H: #{hessian_val}"
    puts "X(k+1): #{xn}"

end


print xn