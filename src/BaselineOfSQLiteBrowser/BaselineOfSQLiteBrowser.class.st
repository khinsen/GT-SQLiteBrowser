Class {
	#name : #BaselineOfSQLiteBrowser,
	#superclass : #BaselineOf,
	#category : #BaselineOfSQLiteBrowser
}

{ #category : #accessing }
BaselineOfSQLiteBrowser >> baseline: spec [
	<baseline>

	spec for: #'common' do: [

		spec
			baseline: 'SQLite3' 
			with: [ spec repository: 'github://pharo-rdbms/Pharo-SQLite3/src' ].

		spec 
			package: #'SQLiteBrowser'
			with: [ spec requires: #('SQLite3') ] ].
]
