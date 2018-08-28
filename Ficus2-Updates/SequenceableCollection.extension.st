Extension { #name : #SequenceableCollection }

{ #category : #'*Ficus2-Updates' }
SequenceableCollection >> asFiPath [

	^ FiPath fromSequenceableCollection: self
]
