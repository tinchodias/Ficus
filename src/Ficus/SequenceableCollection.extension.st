Extension { #name : #SequenceableCollection }

{ #category : #'*Ficus' }
SequenceableCollection >> asFicusPath [

	^ FiPath fromSequenceableCollection: self
]
