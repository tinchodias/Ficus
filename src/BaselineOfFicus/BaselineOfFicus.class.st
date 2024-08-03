Class {
	#name : #BaselineOfFicus,
	#superclass : #BaselineOf,
	#category : #BaselineOfFicus
}

{ #category : #baselines }
BaselineOfFicus >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec baseline: #Yrupe with: [
			spec repository: 'github://tinchodias/Yrupe:master/src' ].
		spec baseline: #PharoMiner with: [
			spec
				repository: 'github://tinchodias/PharoMiner:master/src';
				loads: #(core) ].
		spec
			package: #Ficus;
			package: #FicusExtras with: [
				spec requires: #(#Ficus) ];
			package: #FicusMetamodel with: [
				spec requires: #(#Ficus) ];
			package: #FicusRing with: [
				spec requires: #(#FicusMetamodel) ];
			package: #FicusImpact with: [
				spec requires: #(#FicusRing #FicusStore) ];
			package: #FicusStore with: [
				spec requires: #(#FicusMetamodel) ];
			package: #FicusMonticello with: [
				spec requires: #(#FicusMetamodel) ];
			package: #FicusMonticelloStore with: [
				spec requires: #(#FicusMonticello #FicusStore) ];
			package: #FicusMonticelloYrupe with: [
				spec requires: #(#FicusMonticello #Yrupe #FicusExtras #PharoMiner) ]; 
					"FicusExtras: only because of FiDictionary, which is used in tests."
			package: #FicusEpicea with: [
				spec requires: #(#FicusMetamodel #FicusMonticelloStore) ].
		spec
			group: 'default' with: #('Ficus' 'FicusEpicea' 'FicusStore' 'FicusImpact' 'FicusMonticelloYrupe');
			group: 'mini' with: #('FicusRing' 'FicusMonticello') ]
]
