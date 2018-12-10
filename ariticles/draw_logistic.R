library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

xseq <- seq(-20, 20, 0.01)

px = dlogis(xseq, location = 1.1)
cdfx = plogis(xseq, location = 1.1)

# print(px)

plt.df <- data.frame(x = xseq, y = px)

ggplot(plt.df, aes(x = x, y = y)) + geom_line()

ggsave("./logis-pdf.png")

cdf.plt.df <- data.frame(x = xseq, y = cdfx)

ggplot(cdf.plt.df, aes(x = x, y = y)) + geom_line()

ggsave("./logis-cdf.png")