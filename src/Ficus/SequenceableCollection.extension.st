Extension { #name : #SequenceableCollection }

{ #category : #'*Ficus' }
SequenceableCollection >> asFicusPath [

	^ FiPath fromStream: self readStream
]
