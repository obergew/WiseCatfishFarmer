# ui.R

#UserInterface
library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  # Application title
  HTML("<font face='georgia' color=#000080><h1>Wise Catfish Farmer <img src='catfish.png' height='40' width='100' align='right'></font></h1>"),
  navbarPage(NULL,
             tabPanel("Introduction",
                      h2("Welcome Wise Catfish Farmer", align = "center"),
                      h4("Wise Catfish Farmer helps United States catfish farmers utilize modern aquaculture research to optimize catfish production in the southern United States catfish ponds.
                        Two of the greatest problems with farmed catfish is off-flavor and off-color catfish fillets. However, research at Auburn University has found the occurence of off-flavor and off-color
                        is related to growing pond conditions. From this research, mathematical formulas where determined that accurately predict the occurences of the issues in a pond based on the biotic and abiotic conditions. 
                        Using the two apps, 'Flavor' and 'Color,' on this website you can predict the percentage of your fish that will be on vs off-flavor and on vs off-color given your current conditions. 
                        You can also use the apps as planning tools to help you consider the benefits of making improvements to your ponds."),
                      h4("To get started click on the 'Flavor' or 'Color' tab above and use the sidebar panels on the left to enter pond conditions.")
                      ),
             
             
            
             tabPanel("Flavor",
                      fluidRow(
                        h2("Managing on-flavor occurrence in farm raised catfish production"),
                        column(3,wellPanel(
                          NULL,
                            
                            helpText("Answer the following questions to predict the occurrence of on-flavor in your catfish harvest."),
                            
                            sliderInput("depth", "How deep are your production ponds (in feet)?", 
                                        min=0, max=15, value=5),
                            
                            
                            br(),
                            sliderInput("alk", "What is the average alkalinity (ppm) in your ponds?", 
                                        min=50, max=200, value=114),
                            
                            
                            br(),
                            sliderInput("chlor","What is the average chloride level (ppm)?",
                                        min=0, max=200, value=144),
                            br(),
                            sliderInput("aeration", "What is your pond aeration rate (hp/acre)?", 
                                        min=0, max=15, value=3.25)
                          )
                          ),
                        
                        column(9,
                               NULL,
                               # Show a table summarizing the values entered
                               mainPanel(
                                 htmlOutput("Intro"),
                                 htmlOutput("Answer"),
                                 plotOutput("plotFlavor", height = 500, width = 500),	
                                 htmlOutput("Footer")
                               )
                              )
                        )
                      ),
             tabPanel("Color", fluidRow(
               h2("Managing yellow fillet occurrence in farm raised catfish production"),
               column(3,wellPanel(
                 NULL,
                 
                 helpText("Answer the following questions to predict the occurrence of yellow flesh in your catfish harvest."),
                 
                 sliderInput("daysOff", "How many days will the fish be off feed before harvest?", 
                             min=0, max=170, value=12),
                 
                 
                 br(),
                 radioButtons("snail", "Presence of Snails?",
                              c("Yes" = 1,
                                "No" = 0
                              )),
                 br(),
                 sliderInput("nHarvest","How many harvests occurred in the last year?",
                             min=0, max=10, value=2),
                 br(),
                 radioButtons("shad", "Presence of Threadfin Shad?",
                              c("Yes" = 1,
                                "No" = 0
                              ))
               )
               ),
               
               column(9,
                      NULL,
                      # Show a table summarizing the values entered
                      mainPanel(
                        htmlOutput("IntroColor"),
                        htmlOutput("AnswerColor"),
                        plotOutput("plotColor", height = 500, width = 500),	
                        htmlOutput("FooterColor")
                        
                      )
               )
             ))
            
               ),
  fluidRow(column(12,offset=1,
                  HTML("<br>"),
                  HTML("<h5>This web app was written by"),
                  a("Erik Oberg", href="http://www.linkedin.com/pub/erik-oberg/45/354/82/"),
                  HTML(", BS Fisheries Science - Texas A&M University; MS Marine Science - University of Texas, in "),
                  a("R using RStudio's Shiny package. ", href="http://shiny.rstudio.com/"),
                  a("Contact Erik about the app.", href="mailto:obergew@gmail.com")
          ))
  
             ))