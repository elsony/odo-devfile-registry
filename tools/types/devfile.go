package types

// Devfile is the main structure of devfile from devfile registry
type Devfile struct {
	APIVersion string      `yaml:"apiVersion"`
	MetaData   Metadata    `yaml:"metadata"`
	Components []Component `yaml:"components"`
	Commands   []Command   `yaml:"commands"`
}

// Metadata holds the meta information in the devfile
type Metadata struct {
	GenerateName string `yaml:"generateName"`
}

// Component holds the partial component information in the devfile
type Component struct {
	Type  string `yaml:"type"`
	Alias string `yaml:"alias"`
}

// Command holds the partial command information in the devfile
type Command struct {
	Name string `yaml:"name"`
}
