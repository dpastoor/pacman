curd <- getwd()
usr <- dirname(path.expand("~"))
loc <- file.path(usr, "Desktop")
setwd(loc)

qman <- function(x = "pacman", db = file.path(usr, "Dropbox/Public"), dir=loc) {
    path <- file.path(dir, paste0(x, ".pdf"))
	if (!file.exists(path)) stop(paste(x, "does not exist..."))
    opath <- file.path(db, paste0(x, ".pdf"))
    file.copy(path, opath, overwrite = TRUE)
    message("manual copied!\n")
}


repo <- pack <- "pacman"
base.git = file.path(usr, "GitHub")
quick = TRUE
library(devtools)

unlink(paste0(pack, ".pdf"), recursive = TRUE, force = TRUE)
x <- file.path(base.git, pack)
document(x)
install(x, quick = quick, build_vignettes = FALSE, dependencies = TRUE)

path <- find.package(pack)
system(paste(shQuote(file.path(R.home("bin"), "R")), 
    "CMD", "Rd2pdf", shQuote(path)))

qman(repo, dir=loc)
setwd(curd)
message("Done!")

