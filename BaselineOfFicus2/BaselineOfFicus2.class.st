Class {
	#name : #BaselineOfFicus2,
	#superclass : #BaselineOf,
	#category : #BaselineOfFicus2
}

{ #category : #baseline }
BaselineOfFicus2 >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec
				package: 'Ficus2-Core';
				package: 'Ficus2-Core-Tests' with: [ spec requires: #('Ficus2-Core') ];
				package: 'Ficus2-Updates' with: [ spec requires: #('Ficus2-Core') ];
				package: 'Ficus2-Updates-Tests' with: [ spec requires: #('Ficus2-Core' 'Ficus2-Core-Tests' 'Ficus2-Updates') ].
 ]
]
