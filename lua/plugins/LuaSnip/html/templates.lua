return {
  s( {trig="htmlt"},
    fmt(
      [[

	<!DOCTYPE html>
	<html lang="en">
	  <head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	    <title>{}</title>
	    <link rel="stylesheet" href="{}">
	    <link rel="icon" href="{}" type="image/x-icon">
	  </head>
	  <body>
	    <main>
		<h1>{}</h1>  
	    </main>
	    <script src="{}"></script>
	  </body>
	</html>
      ]],
      {
	i(1, "My Title"),
	i(2, "./style.css"),
	i(3, "./favicon.ico"),
	i(4, "Welcome to The Website"),
	i(5, "./script.js"),
      }
      )
)
}


