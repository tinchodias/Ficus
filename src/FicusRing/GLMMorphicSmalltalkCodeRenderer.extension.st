Extension { #name : #GLMMorphicSmalltalkCodeRenderer }

{ #category : #'*FicusRing' }
GLMMorphicSmalltalkCodeRenderer >> textMorphForModel: aTextModel [
	| morph  |
	morph := GLMPluggableTextMorph new.
	morph styler workspace: aTextModel.
	morph styler environment: aTextModel environment.
	morph
		on: aTextModel
			text: #text
			accept: #accept:notifying:
			readSelection: #selection
			menu: #menu:shifted:;
		changedAction: [:aText| 
			aText asString trimBoth ifNotEmpty:  [aTextModel text: aText] ];
		onKeyStrokeSend: #keystroke:from: to: aTextModel;
		layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		color: Smalltalk ui theme backgroundColor;
		font: StandardFonts codeFont;
		yourself.
	^ morph
]
