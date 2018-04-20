require 'csv'

module NewtonRaphson
end

module Weib
    def self.estimate(data)
        puts "Hello!"
    end

    def self.loglikelihood(beta, gamma, source_data)
        
        weight = source_data.length

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
    end

    def self.hessian
    end
end

data_table = CSV.read("../../csv_data/AQI.csv")

aqi_data = []

1.upto(data_table.length - 1) do |row|

    aqi_data << data_table[row][0].to_f

end

# Weib.estimate aqi_data
print Weib.loglikelihoodOpt 1, 1, aqi_data