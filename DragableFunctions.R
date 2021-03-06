library(shiny)

dataSelect <- reactiveValues(type = "all")

# To be called from ui.R
DragableChartOutput <- function(inputId, width="500px", height="500px") {
  style <- sprintf("width: %s; height: %s;",
    validateCssUnit(width), validateCssUnit(height))
  tagList(
    tags$script(src = "d3.v3.min.js"),
    includeScript("ChartRendering.js"),
    div(id=inputId, class="Dragable", style = style,
      tag("svg", list())
    )
  )
}

# To be called from server.R
renderDragableChart <- function(expr, env = parent.frame(), quoted = FALSE, color = "orange", r = 10) {
  installExprFunction(expr, "data", env, quoted)
  function(){
    data <- lapply(1:dim(data())[1], function(idx) list(x = data()$x[idx], y = data()$y[idx], r = r))
    list(data = data, col = color)
  } 
}