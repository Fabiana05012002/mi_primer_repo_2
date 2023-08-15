library(shiny)

ui <- fluidPage(
  titlePanel("Planificador de Eventos"),
  
  sidebarLayout(
    sidebarPanel( 
      width = 4,
      textInput(inputId = "evento", 
                label = "Nombre del Evento:"),
      br(),
      selectInput(inputId = "selector_eventos", 
                  label = "Tema del evento:", 
                  choices = c("Boda", "Fiesta de cumpleaños", "Conferencia", "Otro")),
      
      numericInput(inputId = "invitados", 
                   label = "Número de invitados:", 
                   value = 58, 
                   min = 25, 
                   max = 120),
      
      selectInput(inputId = "selector_provincias", 
                  label = "Provincia:", 
                  choices = c("San José", "Cartago", "Heredia", "Alajuela", "Limón", "Guanacaste", "Puntarenas"))
    ),
    
    mainPanel(
      width = 7,
      br(),
      br(),
      h2(span("Vamos a planificar su día especial", style = "color:blue"), align = "center"),
      tags$hr(style = "border-color: blue;"),
      h3("Detalles del evento:"),
      br(),
      textOutput("evento"),
      br(),
      textOutput("tema"),
      br(),
      textOutput("detalle")
    )
  )
)

server <- function(input, output, session) {
  output$evento <- renderText({
    evento <- input$evento
    eventos_texto <- ifelse(length(evento) > 0, 
                            paste("Nombre del Evento:", evento), 
                            "Nombre del Evento:")
    eventos_texto
  })
  
  output$tema <- renderText({
    temas <- input$selector_eventos
    temas_texto <- ifelse(length(temas) > 0, 
                          paste("Tema del evento:", paste(temas, collapse = ", ")), 
                          "Tema del evento:")
    temas_texto
  })
  
  output$detalle <- renderText({
    num_invitados <- input$invitados
    temas <- input$selector_eventos
    provincias <- input$selector_provincias
    provincia_texto <- ifelse(length(provincias) > 0,
                              paste("y será llevada a cabo en", paste(provincias, collapse = ", ")),
                              "y será llevada a cabo en")
    detalles_texto <- paste("Nombre de invitados y ubicación:", 
                            "El evento", temas, "tendrá", num_invitados, "invitados,", provincia_texto)
    detalles_texto
  })
}

shinyApp(ui, server)