Extension { #name : #FiShot }

{ #category : #'*FicusStore' }
FiShot >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 35> 

	composite morph
		title: [ 'Tree' ];
		display: [:shot | 
			(FiInspector new 
				rootShot: shot;
				buildWithSpec;
				yourself) widget widget ]
				
			
]
