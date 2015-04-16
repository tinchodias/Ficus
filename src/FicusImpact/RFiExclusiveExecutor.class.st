"
I provide non-blocking mutual exclusion for execution of block closures. When a new block closure will be executed, the eventual current execution is terminated.
"
Class {
	#name : #RFiExclusiveExecutor,
	#superclass : #Object,
	#instVars : [
		'currentProcess'
	],
	#category : #'FicusImpact-UI'
}

{ #category : #scheduling }
RFiExclusiveExecutor >> spawnNewProcessWith: anAction [
	
	currentProcess ifNotNilDo: #terminate.

	currentProcess := [ 
		anAction value.
		currentProcess := nil.
	] fork
	"Maybe: forkAt: Processor userBackgroundPriority"
]
