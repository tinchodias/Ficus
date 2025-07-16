Extension { #name : #SequenceableCollection }

{ #category : #'*Ficus-Updates' }
SequenceableCollection >> asFiPath [

	^ FiPath fromSequenceableCollection: self
]
