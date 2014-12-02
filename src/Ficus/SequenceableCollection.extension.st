Extension { #name : #SequenceableCollection }

{ #category : #'*Ficus' }
SequenceableCollection >> asFiPath [

	^ FiPath fromSequenceableCollection: self
]
