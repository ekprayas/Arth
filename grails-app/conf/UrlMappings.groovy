class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}
        "/all"(view:"/index")
        "/"(controller:"home", action:"index")
        "500"(view:'/error')
	}
}
