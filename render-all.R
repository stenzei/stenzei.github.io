# Script to render all posts and other pages like index.Rmd
# This is particulary useful, when changes affect all pages.

rmarkdown::render("index.Rmd", output_options = list(self_contained = FALSE), quiet = TRUE)
rmarkdown::render("imprint.Rmd", output_options = list(self_contained = FALSE), quiet = TRUE)
rmarkdown::render("about.Rmd", output_options = list(self_contained = FALSE), quiet = TRUE)
posts <- list.files("posts", pattern = "*.Rmd")
posts <- paste("posts/", posts, sep = "")

# Add footer with Twitter-link
footer <- function(current_page) {
  current_page <- gsub("Rmd", "html", current_page)
  current_page <- paste0("https://twitter.com/share?url=https://stenzei.github.io/", current_page)
  paste('

___

Share this post in Twitter: [<i class="fa fa-twitter fa-2x" aria-hidden="true"></i>](', 
current_page,')     
  
[Imprint/Impressum (German)]("imprint.html")
    
&copy; 2018 stenze
  ')
}

# Render and apply footer function.
render_post <- function(x) {
  print(paste("Render", x))
  original_post <- readr::read_file(x) 
  readr::write_file(footer(x), x, append = TRUE)
  try(
    expr = rmarkdown::render(x, quiet = TRUE)
  )
  readr::write_file(original_post, x, append = FALSE)
}

lapply(posts, render_post)
