# Script to render all sites
rmarkdown::render("index.Rmd")
rmarkdown::render("imprint.Rmd")
rmarkdown::render("about.Rmd")
posts <- list.files("posts", pattern = "*.Rmd")
posts <- paste("posts/", posts, sep = "")
lapply(posts, function(x){rmarkdown::render(x)})

