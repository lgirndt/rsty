# rsty

rsty is simple rest client I use to test our API from the command line.

Therefore it is intended to provide a simplified access to a Rest API on a
distinct host. You simply configure the base parameter to access this API
in the config file

<pre>
	{
	  "base_url":"http://localhost:8080/your/api/v1.0",
	  "user":"user@name.com",
	  "password":"user",
	  "base_params" :  {"api_key" : "1alsdifnsdflkj"}
	}	
</pre>

It is expected that the config file exists in the working directory.
Then you can use rsty simply by

<pre>
rsty GET /campaigns	
</pre>

Parameters are simply provided as key=value arguments. rsty handles POST
parameters and query parameters transparently.

<pre>
rsty POST /book orderId=345 customer=me
</pre>