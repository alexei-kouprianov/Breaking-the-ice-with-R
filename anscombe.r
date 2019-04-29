# Anscombe's quartet

anscombe <- read.table("anscombe.txt", h=TRUE, sep="\t")

summary(anscombe)
apply(anscombe, 2, mean)
apply(anscombe, 2, sd)

cor(anscombe$x.1, anscombe$y.1)
cor(anscombe$x.2, anscombe$y.2)
cor(anscombe$x.3, anscombe$y.3)
cor(anscombe$x.4, anscombe$y.4)

# Previews

plot(anscombe$x.1,anscombe$y.1,xlim=c(0,20),ylim=c(0,20),main="Anscombe's quartet",xlab="",ylab="")
abline(lm(anscombe$y.1~anscombe$x.1), lty=2, col="red")

plot(anscombe$x.2,anscombe$y.2,xlim=c(0,20),ylim=c(0,20),main="Anscombe's quartet",xlab="",ylab="")
abline(lm(anscombe$y.2~anscombe$x.2), lty=2, col="red")

plot(anscombe$x.3,anscombe$y.3,xlim=c(0,20),ylim=c(0,20),main="Anscombe's quartet",xlab="",ylab="")
abline(lm(anscombe$y.3~anscombe$x.3), lty=2, col="red")

plot(anscombe$x.4,anscombe$y.4,xlim=c(0,20),ylim=c(0,20),main="Anscombe's quartet",xlab="",ylab="")
abline(lm(anscombe$y.4~anscombe$x.4), lty=2, col="red")

summary(lm(anscombe$y.1~anscombe$x.1))
summary(lm(anscombe$y.2~anscombe$x.2))
summary(lm(anscombe$y.3~anscombe$x.3))
summary(lm(anscombe$y.4~anscombe$x.4))

png("anscombe.all.png", height=500, width=500)
par(mfrow=c(2,2))
plot(anscombe$x.1,anscombe$y.1,xlim=c(0,20),ylim=c(0,20),main="I",xlab="",ylab="")
abline(lm(anscombe$y.1~anscombe$x.1), lty=2, col="red")
plot(anscombe$x.2,anscombe$y.2,xlim=c(0,20),ylim=c(0,20),main="II",xlab="",ylab="")
abline(lm(anscombe$y.2~anscombe$x.2), lty=2, col="red")
plot(anscombe$x.3,anscombe$y.3,xlim=c(0,20),ylim=c(0,20),main="III",xlab="",ylab="")
abline(lm(anscombe$y.3~anscombe$x.3), lty=2, col="red")
plot(anscombe$x.4,anscombe$y.4,xlim=c(0,20),ylim=c(0,20),main="IV",xlab="",ylab="")
abline(lm(anscombe$y.4~anscombe$x.4), lty=2, col="red")
dev.off()

png("anscombe_1500px.png", height=1500, width=1500)
# par(mfrow=c(2,2), cex=3, lwd=3, mar=c(5,4,4,2)+.1)
par(mfrow=c(2,2), cex=3, lwd=3, mar=c(2,2,2,1)+.1)
plot(anscombe$x.1,anscombe$y.1,xlim=c(0,20),ylim=c(0,20),main="I",xlab="",ylab="")
abline(lm(anscombe$y.1~anscombe$x.1), lty=2, col="red")
plot(anscombe$x.2,anscombe$y.2,xlim=c(0,20),ylim=c(0,20),main="II",xlab="",ylab="")
abline(lm(anscombe$y.2~anscombe$x.2), lty=2, col="red")
plot(anscombe$x.3,anscombe$y.3,xlim=c(0,20),ylim=c(0,20),main="III",xlab="",ylab="")
abline(lm(anscombe$y.3~anscombe$x.3), lty=2, col="red")
plot(anscombe$x.4,anscombe$y.4,xlim=c(0,20),ylim=c(0,20),main="IV",xlab="",ylab="")
abline(lm(anscombe$y.4~anscombe$x.4), lty=2, col="red")
dev.off()
