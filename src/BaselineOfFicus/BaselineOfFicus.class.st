Class {
	#name : #BaselineOfFicus,
	#superclass : #BaselineOf,
	#category : #BaselineOfFicus
}

{ #category : #baseline }
BaselineOfFicus >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec
				package: 'Ficus-Core';
				package: 'Ficus-Core-Tests' with: [ spec requires: #('Ficus-Core') ];
				package: 'Ficus-Updates' with: [ spec requires: #('Ficus-Core') ];
				package: 'Ficus-Updates-Tests' with: [ spec requires: #('Ficus-Core' 'Ficus-Core-Tests' 'Ficus-Updates') ].
 ]
]
