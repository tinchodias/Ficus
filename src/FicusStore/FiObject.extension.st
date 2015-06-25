Extension { #name : #FiObject }

{ #category : #'*FicusStore' }
FiObject >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 35> 

	composite morph
		title: 'Ficus tree';
		display: [:shot | 
			(FiInspector new 
				rootShot: shot;
				buildWithSpec;
				yourself) widget widget ]
				
			
]
