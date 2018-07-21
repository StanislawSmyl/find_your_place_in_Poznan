fluidPage(
    theme = shinytheme("yeti"),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),
    navbarPage(
        "WarsawAnalytica",
        tabPanel(
            "Application",
            sidebarLayout(
                sidebarPanel(width = 3,
                             h3("Tell us something about yourself!"),
                             h5('Pick adress and type of city'),
                             div(style="display: inline-block;vertical-align:top; width: 67%;", 
                                 selectizeInput("address",
                                                label="Where do you live?",
                                                choices = adress_autocomplete,
                                                options = list(
                                                    placeholder = 'Select street',
                                                    onInitialize = I('function() { this.setValue(""); }')
                                                )
                                 )),
                             div(style="display: inline-block;vertical-align:bottom; width: 20%; margin-left:10%", 
                                 numericInput("building", label = 'Building No:',
                                              value = 1, min = 0, max = 1000, step = 1)),
                             hr(),
                             div(style="display: inline-block;vertical-align:bottom; width: 50%;", 
                                 pickerInput("city", label = 'City type:',
                                             c("village", "city under 19k", "city 19-99k", "city 100-499k", "city over 500k"), options = list('actions-box' = TRUE),
                                             selected = "city over 500k")),
                             div(style="display: inline-block;vertical-align:top; width: 38%; margin-left:10%", 
                                 materialSwitch("buildings", "Love lower buildings!"), status = "primary", 
                                 right = TRUE),
                             hr(),
                             pickerInput("sex", label = "Sex", choices = c("Prefer not to say", "Male", "Female")),
                             hr(),
                             noUiSliderInput("age", label = "Age", min = 18, max = 100, value = 25, step = 1),
                             hr(),
                             noUiSliderInput("income", 
                                             label = div(
                                                 div('Income in PLN (net)'), 
                                                 div(style='float:right; font-weight:100;', 'or more')),
                                             value = 5000, min = 1500, max = 10000, step = 500),
                             hr(),
                             div('Attitude towards:'),
                             div(style="display: inline-block;vertical-align:bottom; width: 20%; margin-left:10%", 
                                 numericInput("children", label = 'Children',
                                              value = 5, min = 1, max = 10, step = 1)),
                             div(style="display: inline-block;vertical-align:bottom; width: 20%; margin-left:10%", 
                                 numericInput("teenagers", label = 'Teenagers',
                                              value = 5, min = 1, max = 10, step = 1)),
                             div(style="display: inline-block;vertical-align:bottom; width: 20%; margin-left:10%", 
                                 numericInput("students", label = 'Students',
                                              value = 5, min = 1, max = 10, step = 1)),
                             hr(),
                             pickerInput(inputId = "amenities", 
                                         label = "Which amenities are you interested in?", 
                                         choices = c("Prefer not to say", "Cafes", "Food", "Public transport", 
                                                     "Service point", "Chain shops", "Education", "Culture & entertainment",
                                                     "Shopping malls", "Health", "Places of worship"), options = list('actions-box' = TRUE), 
                                         multiple = T, selected = "Prefer not to say"),
                             hr(),
                             pickerInput("education", label = "What is your education level?",
                                         c("Prefer not to say", "Primary", "Vocational", "Secondary", "Higher"), options = list('actions-box' = TRUE),
                                         selected = NULL),
                             submitButton()
                ),
                
                mainPanel(
                    h2("The darker the square, the more you'll like it!"),
                    leafletOutput("map", height = 600),
                    uiOutput("tab")
                )
            )
            
        ),
        tabPanel("Documentation",
                 h3("Where would you like to live in Poznan?"),
                 p("The problem of people not fully satisfied with their current address is a pervasive one. Our application is a siple tool which based on a person's input proposes a place they might like."),
                 h3("Data"),
                 HTML("<ul>
                      <li>PostgreSQL (demography, incomes, POIs) and APIs provided by DataWise</li>
                      <li>Overpass Turbo</li>
                      <li>Scraping of <a href='https://www.otodom.pl/'>www.otodom.pl</a></li>
                      </ul>"),
                 h3("Methods"),
                 HTML("<ul>
                      <li>Spatial coordinates on a 500m grid</li>
                      <li>K-means clustering of grid elements (as sets of inhabitants)</li>
                      <li>Application user data imputation with random forest</li>
                      <li>Classification of the user to one of the clusters and propositions of new neighbourhoods</li>
                      </ul>"))
    )
        )
