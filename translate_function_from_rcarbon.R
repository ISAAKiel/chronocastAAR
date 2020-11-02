# As example, taken from ahb108/rcarbon

#' @title Convert to a CalDates object 
#' @description Convert other calibrated date formats to an rcarbon CalDates object. 
#' @param x One or more calibrated dated to convert (currently only BchronCalibratedDates and oxcAARCalibratedDatesList objects are supported)
#' @return A CalDates object
#' @examples
#' \dontrun{ 
#' library(Bchron)
#' library(oxcAAR)
#' quickSetupOxcal()
#' dates <- data.frame(CRA=c(3200,2100,1900), Error=c(35,40,50))
#' bcaldates <- BchronCalibrate(ages=dates$CRA, ageSds=dates$Error, 
#' calCurves=rep("intcal13", nrow(dates)))
#' rcaldates <- rcarbon::calibrate(dates$CRA, dates$Error, calCurves=rep("intcal13"))
#' ocaldates <- oxcalCalibrate(c(3200,2100,1900),c(35,40,50),c("a","b","c"))
#' ## Convert to rcarbon format
#' caldates.b <- as.CalDates(bcaldates)
#' caldates.o <- as.CalDates(ocaldates)
#' ## Comparison plot
#' plot(rcaldates$grids[[2]]$calBP,rcaldates$grids[[2]]$PrDens, 
#' type="l", col="green", xlim=c(2300,1900))
#' lines(caldates.b$grids[[2]]$calBP,caldates.b$grids[[2]]$PrDens, col="red")
#' lines(caldates.o$grids[[2]]$calBP,caldates.o$grids[[2]]$PrDens, col="blue")
#' legend("topright", legend=c("rcarbon","Bchron","OxCal"), col=c("green","red","blue"), lwd=2)
#' }
#' @export
#' 
as.CalDates <- function(x){
  if (!any(class(x)%in%c("BchronCalibratedDates","oxcAARCalibratedDatesList"))){
    stop("Currently, x must be of class BchronCalibratedDates or oxcAARCalibratedDatesList")
  }
  if (any(class(x)=="BchronCalibratedDates")){	    
    methods <- "Bchron"
    reslist <- vector(mode="list", length=2)
    sublist <- vector(mode="list", length=length(x))
    names(sublist) <- names(x)
    names(reslist) <- c("metadata","grids")
    ## metadata
    df <- as.data.frame(matrix(ncol=11, nrow=length(x)), stringsAFactors=FALSE)
    names(df) <- c("DateID","CRA","Error","Details","CalCurve","ResOffsets","ResErrors","StartBP","EndBP","Normalised","CalEPS")
    df$DateID <- names(x)
    df$CRA <- as.numeric(unlist(lapply(X=x, FUN=`[[`, "ages")))
    df$Error <- as.numeric(unlist(lapply(X=x, FUN=`[[`, "ageSds")))
    df$CalCurve <- as.character(unlist(lapply(X=x, FUN=`[[`, "calCurves")))
    df$ResOffsets <- NA
    df$ResErrors <- NA
    df$StartBP <- NA
    df$EndBP <- NA
    df$Normalised <- TRUE
    reslist[["metadata"]] <- df
    ## grids
    for (i in 1:length(x)){
      tmp <- x[[i]]
      res <- data.frame(calBP=rev(tmp$ageGrid),PrDens=rev(tmp$densities))
      class(res) <- append(class(res),"calGrid")        
      sublist[[i]] <- res
    }
    reslist[["grids"]] <- sublist
    reslist[["calmatrix"]] <- NA
    class(reslist) <- c("CalDates",class(reslist))
    return(reslist)
  }
  if (any(class(x)=="oxcAARCalibratedDatesList")){
    reslist <- vector(mode="list", length=2)
    sublist <- vector(mode="list", length=length(x))
    names(sublist) <- names(x)
    names(reslist) <- c("metadata","grids")
    ## metadata
    df <- as.data.frame(matrix(ncol=11, nrow=length(x)), stringsAFactors=FALSE)
    names(df) <- c("DateID","CRA","Error","Details","CalCurve","ResOffsets","ResErrors","StartBP","EndBP","Normalised","CalEPS")
    df$DateID <- names(x)
    df$CRA <- as.numeric(unlist(lapply(X=x, FUN=`[[`, "bp")))
    df$Error <- as.numeric(unlist(lapply(X=x, FUN=`[[`, "std")))
    df$CalCurve=lapply(lapply(lapply(lapply(lapply(x,FUN=`[[`,"cal_curve"),FUN=`[[`,"name"),strsplit," "),unlist),FUN=`[[`,2)
    df$CalCurve=tolower(df$CalCurve)
    df$ResOffsets <- NA
    df$ResErrors <- NA
    df$StartBP <- NA
    df$EndBP <- NA
    df$Normalised <- TRUE
    df$CalEPS <- 0
    reslist[["metadata"]] <- df
    ## grids
    for (i in 1:length(x)){
      tmp <- x[[i]]$raw_probabilities  
      rr <- range(tmp$dates)
      res <- 	approx(x=tmp$dates,y=tmp$probabilities,xout=ceiling(rr[1]):floor(rr[2]))
      res$x <- abs(res$x-1950)
      res <- data.frame(calBP=res$x,PrDens=res$y)
      res$PrDens <- res$PrDens/sum(res$PrDens)
      class(res) <- append(class(res),"calGrid")        
      sublist[[i]] <- res
    }
    reslist[["grids"]] <- sublist
    reslist[["calmatrix"]] <- NA
    class(reslist) <- c("CalDates",class(reslist))
    return(reslist)
  }       
}
