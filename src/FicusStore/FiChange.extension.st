Extension { #name : #FiChange }

{ #category : #'*FicusStore' }
FiChange >> ficusInspectorDefinitionString [

	^ self printString
]

{ #category : #'*FicusStore' }
FiChange >> gtChangeInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 34> 

	composite morph
		title: 'Ficus Change tree';
		display: [:shot | 
			((FiChangeInspector newWith: shot)
				buildWithSpec;
				yourself) widget widget ]
]
