<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row"> 
	    <!-- Navigation -->    	
	    	<div class="large-12 columns">
	    		<div class="row collapse"><h2 class="subheader"><g:message code="default.show.label" args="[entityName]" /></h2></div>
				<ul class="inline-list">
				  <li class="right"><span class="radius secondary label"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span></li>
				  <li class="right"><span class="radius secondary label"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></li>
				</ul>
				<hr/>
	        </div>	    
	    </div>
	    <div class="row">
	    	<div class="large-12 columns">
	    		<g:if test="\${flash.message}">
				<div class="alert-box" role="status">\${flash.message}</div>
				</g:if>
				<div class="panel">
					<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
						allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
						props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
						Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
						props.each { p -> %>
						<g:if test="\${${propertyName}?.${p.name}}">
						<div class="row collapse">
							<div class="large-3 columns">
							  <label class="inline"><b><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />:</b></label>
							</div>
							<div class="large-9 columns">
							<%  if (p.isEnum()) { %>
								<label class="inline"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></label>
							<%  } else if (p.oneToMany || p.manyToMany) { %>
								<g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
								<label class="inline"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></label>
								</g:each>
							<%  } else if (p.manyToOne || p.oneToOne) { %>
								<label class="inline"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></label>
							<%  } else if (p.type == Boolean || p.type == boolean) { %>
								<label class="inline"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></label>								
							<%  } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
								<label class="inline"><g:formatDate date="\${${propertyName}?.${p.name}}" /></label>
							<%  } else if (!p.type.isArray()) { %>
								<label class="inline"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></label>								
							<%  } %>
							</div>
						</div>
						</g:if>
					<%  } %>
				</div>
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="\${${propertyName}?.id}" />
						<g:link class="small button" action="edit" id="\${${propertyName}?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="small button" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</div>    	
	    </div>
	</body>
</html>
