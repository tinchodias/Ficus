Extension { #name : #FiRelativePath }

{ #category : #'*FicusMetamodel' }
FiRelativePath >> asMetamodelSpot [
	
	^ FiMetamodelSpot spotFromPath: self
]
