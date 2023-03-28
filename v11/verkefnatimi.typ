#set text(font: "Berkeley Mono", size: 14pt)
#set page(paper: "us-letter", margin: 1cm)
#set heading(numbering: "a)")

#let question(content, fill: gray) = {
  set text(style: "italic")
  rect(
    inset: 8pt, 
    radius: 4pt, 
    width: 100%, 
    [#text(weight:"bold", style: "normal")[Spurning: ]\ #content])
}


