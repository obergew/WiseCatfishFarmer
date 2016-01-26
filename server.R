library(ggplot2)
shinyServer(function(input, output) {
  
  output$Intro <- renderUI({
    HTML(" <h3>Use the control panel on the left to get an estimate.</h3>")
  })
  
  output$Footer <- renderUI({
    HTML("<p>The answers to your questions on the left are put into an equation
         developed by Corey Courtwright of Auburn University who surveyed catfish farmer production
         in West Alabama, Mississippi, and Arkansas. 
         The tool can be used to guide farm management and better understand the factors that increase on-flavor and decrease off-flavor. 
         </p><br><p>No model could ever predict exactly what will occur in a complex biological system and your results may slightly vary.</p> 
         <br>")
  })
  
  
  # Reactive expression to compose a data frame containing all of the values
  data <- reactive({
    DepthOfPond<-input$depth
    Alkalinity<-input$alk 
    Chloride<-input$chlor
    Aeration<-input$aeration
    
    PercentONFlavor<-100*sin(-0.0491+0.0739*DepthOfPond+0.0032*Alkalinity+0.0003*Chloride+0.059*Aeration)^2
    
    # Compose data frame
    df<-setNames(data.frame(DepthOfPond, Alkalinity, Chloride, Aeration), c("Depth of ponds (feet)", "Alkalinity (ppm)", "Chloride level (ppm)", "Aeration rate (hp/ac)")) 
    df
  })
  # Show the values using an HTML table
  
  output$values <- renderTable({
    data()
  })
  output$Answer<-renderText({
    
    DepthOfPond<-input$depth
    Alkalinity<-input$alk 
    Chloride<-input$chlor
    Aeration<-input$aeration
    PercentONFlavor<-100*sin(-0.0491+0.0739*DepthOfPond+0.0032*Alkalinity+0.0003*Chloride+0.059*Aeration)^2
    
    PoNrounded<-round(PercentONFlavor, digits=1)
    paste0(list("<h3><b><FONT COLOR=#000066>Given depth of ponds is ", DepthOfPond, "(feet), alkalinity is ", Alkalinity, "(ppm), chloride level is ",Chloride,"(ppm), and aeration rate is ", Aeration,"(hp/ac) you should expect on-flavor in ",PoNrounded,"% of your catfish.</FONT></b>"))
    
  })
  output$plotFlavor<-renderPlot({
    
    DepthOfPond<-input$depth
    Alkalinity<-input$alk 
    Chloride<-input$chlor
    Aeration<-input$aeration
    
    Pon<-100*sin(-0.0491+0.0739*DepthOfPond+0.0032*Alkalinity+0.0003*Chloride+0.059*Aeration)^2
    
    Poff<-100-Pon
    df<-data.frame(taste = factor(c("Normal","Off Flavor"), levels=c("Normal","Off Flavor")),
                   total_percentage = c(Pon, Poff))
    
    print(ggplot(data=df, aes(x=taste, y=total_percentage, fill=taste)) +
            geom_bar(colour="black", stat="identity") +
            scale_fill_manual(values=c("white","brown"))+
            guides(fill=FALSE)+
            scale_y_continuous(limits=c(0,100),breaks=seq(0,100,10))+
            theme(axis.title.x = element_text(size=20),
                  axis.title.y = element_text(size=20),
                  axis.text.x  = element_text(size=20),
                  axis.text.y  = element_text(size=20))+
            xlab("Taste") + 
            ylab("Occurrence (%)")
    )
  })
  output$IntroColor <- renderUI({
    HTML(" <h3>Use the control panel on the left to get an estimate.</h3>")
  })
  
  output$FooterColor <- renderUI({
    HTML("<p>The answers to your questions on the left are put into an equation
         developed by Corey Courtwright of Auburn University who surveyed catfish farmer production
         in West Alabama, Mississippi, and Arkansas. 
         The tool can be used to guide farm management and better understand the factors that increase on-flavor and decrease off-flavor. 
         </p><br><p>No model could ever predict exactly what will occur in a complex biological system and your results may slightly vary.</p> 
         <br>")
  })
  # Reactive expression to compose a data frame containing all of the values
  data <- reactive({
    Y<-1
    N<-0
    DaysOffFeed<-input$daysOff
    Snails<-as.numeric(input$snail) 
    NumberHarvest<-input$nHarvest
    ThreadShad<-as.numeric(input$shad)
    
    PercentYellow<-100*sin(0.32437+0.00408*DaysOffFeed+0.06316*ThreadShad-0.15036*Snails-0.04736*NumberHarvest)^2
    
    # Compose data frame
    df<-setNames(data.frame(DaysOffFeed, Snails, NumberHarvest, ThreadShad), c("Days off feed", "Presences of snails", "Number of harvests in the last year", "Presence of threadfin shad")) 
    df
  })
  # Show the values using an HTML table
  
  output$values <- renderTable({
    data()
  })
  output$AnswerColor<-renderText({
    Y<-1
    N<-0
    DaysOffFeed<-input$daysOff
    Snails<-as.numeric(input$snail) 
    NumberHarvest<-input$nHarvest
    ThreadShad<-as.numeric(input$shad)
    if(Snails==1){
      s<-paste0("")
    }else{s<-paste0("not")}
    if(ThreadShad==1){
      t<-paste0("")
    }else{t<-paste0("not")}
    PercentYellow<-100*sin(0.32437+0.00408*DaysOffFeed+0.06316*ThreadShad-0.15036*Snails-0.04736*NumberHarvest)^2
    PYrounded<-round(PercentYellow, digits=1)
    paste0(list("<FONT COLOR=#000066><h3><b>Given you will remove feed ", DaysOffFeed, " days before harvest, snails are ", s, " present, there were ",NumberHarvest, " harvests last year, and Threadfin shad are ", 
    t, " present the expected percentage of yellow fillets is:",PYrounded,"%</b></FONT>"))
    
  })
  output$plotColor<-renderPlot({
    Y<-1
    N<-0
    DaysOffFeed<-input$daysOff
    Snails<-as.numeric(input$snail) 
    NumberHarvest<-input$nHarvest
    ThreadShad<-as.numeric(input$shad)
    
    PY<-100*sin(0.32437+0.00408*DaysOffFeed+0.06316*ThreadShad-0.15036*Snails-0.04736*NumberHarvest)^2
    PN<-100-PY
    dfColor<-data.frame(fillet = factor(c("Normal","Yellow"), levels=c("Normal","Yellow")),
                   total_percentage = c(PN, PY))
    
    print(ggplot(data=dfColor, aes(x=fillet, y=total_percentage, fill=fillet)) +
            geom_bar(colour="black", stat="identity") +
            scale_fill_manual(values=c("white","yellow"))+
            guides(fill=FALSE)+
            scale_y_continuous(limits=c(0,100),breaks=seq(0,100,10))+
            theme(axis.title.x = element_text(size=20),
                  axis.title.y = element_text(size=20),
                  axis.text.x  = element_text(size=20),
                  axis.text.y  = element_text(size=20))+
            xlab("Fillet Color") + 
            ylab("Occurrence (%)")
    )
  })
})