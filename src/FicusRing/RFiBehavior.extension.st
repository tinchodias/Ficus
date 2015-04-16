Extension { #name : #RFiBehavior }

{ #category : #'*FicusRing' }
RFiBehavior >> allUnsentMessages [
	"Answer an array of all the messages defined by the receiver that are not sent anywhere in the system."

	^ self systemNavigation allUnsentMessagesIn: self selectors
]

{ #category : #'*FicusRing' }
RFiBehavior >> systemNavigation [

	^ SystemNavigation new 
		environment: self environment;
		yourself
]
