## ui.R
library(shiny)
library(shinydashboard)
library(proxy)
library(recommenderlab)
library(reshape2)
library(plyr)
library(dplyr)
library(DT)
library(RCurl)

movies <- read.csv("C:/Users/Venkatadri Arava/Desktop/R Stuff/Finale/Movie-Recomm/movies.csv", header = TRUE, stringsAsFactors=FALSE)
movies <- movies[with(movies, order(title)), ]

ratings <- read.csv("C:/Users/Venkatadri Arava/Desktop/R Stuff/Finale/Movie-Recomm/ratings100k.csv", header = TRUE)


shinyUI(dashboardPage(skin="blue",
                      dashboardHeader(title = "Movie Recommenders"),
                      dashboardSidebar(
                        sidebarMenu(
                          menuItem("Movies", tabName = "movies", icon = icon("star-o")),
                          menuItem("About", tabName = "about", icon = icon("question-circle")),
                          menuItem(
                            list(
                              
                              selectInput("select", label = h5("Select 3 Movies That You Like"),
                                          choices = as.character(movies$title[1:length(unique(movies$movieId))]),
                                          selectize = FALSE,
                                          selected = "Shawshank Redemption, The (1994)"),
                              selectInput("select2", label = NA,
                                          choices = as.character(movies$title[1:length(unique(movies$movieId))]),
                                          selectize = FALSE,
                                          selected = "Forrest Gump (1994)"),
                              selectInput("select3", label = NA,
                                          choices = as.character(movies$title[1:length(unique(movies$movieId))]),
                                          selectize = FALSE,
                                          selected = "Silence of the Lambs, The (1991)"),
                              submitButton("Submit")
                            )
                          )
#                          menuItem(
#                             checkboxGroupInput("genre", label = h5("Genre of Recommendations:"),
#                                                 c("Action", "Adventure", "Animation", "Childrens",
#                                                   "Comedy", "Crime", "Documentary", "Drama",
#                                                   "Fantasy", "Film-Noir", "Horror", "Musical",
#                                                   "Mystery", "Romance", "Sci-Fi", "Thriller",
#                                                   "War", "Western"),
#                                                 selected = c("Action", "Adventure", "Comedy", "Crime", 
#                                                              "Documentary", "Drama", "Romance", "Thriller"),
#                                                 inline = FALSE))
                          )
                      ),
                      
                      
                      dashboardBody(
                        tags$head(
                          tags$style(type="text/css", "select { max-width: 360px; }"),
                          tags$style(type="text/css", ".span4 { max-width: 360px; }"),
                          tags$style(type="text/css",  ".well { max-width: 360px; }")
                        ),
                        
                        tabItems(  
                          tabItem(tabName = "about",
                                  h2("About this App"),
                                  
                                  HTML('<br/>'),
                                  
                                  fluidRow(
                                    box(title = "Movie Reccomender based on UBCF Model", background = "black", width=7, collapsible = TRUE,
                                        
                                        helpText(p(strong("This application a movie reccomnder using the MovieLense dataset."))),
                                        
                                       
                                      )
                                  )
                            ),
                          tabItem(tabName = "movies",
                                  fluidRow(
                                    box(
                                      width = 6, status = "info", solidHead = TRUE,
                                      title = "Other Movies You Might Like",
                                      tableOutput("table")),
                                    valueBoxOutput("tableRatings1"),
                                    valueBoxOutput("tableRatings2"),
                                    valueBoxOutput("tableRatings3"),
                                    HTML('<br/>'),
                                    box(DT::dataTableOutput("myTable"), title = "Table of All Movies", width=12, collapsible = TRUE)
                                )
                            )
                        )
                    )
              )
          )              