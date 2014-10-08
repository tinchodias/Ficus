Extension { #name : #RBBrowserEnvironment }

{ #category : #'*FicusRing-override' }
RBBrowserEnvironment >> allClassesAndTraitsDo: aBlock [
	self systemDictionary allClassesAndTraitsDo: [ :each | aBlock value: each; value: each theMetaClass  ]
]

{ #category : #'*FicusRing-override' }
RBBrowserEnvironment >> whichProtocolIncludes: aSelector in: aClass [
	^aClass whichCategoryIncludesSelector: aSelector
]
