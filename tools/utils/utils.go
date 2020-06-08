package utils

import (
	"io/ioutil"
	"strings"

	"github.com/elsony/devfile-registry/tools/types"
	"gopkg.in/yaml.v2"
)

const (
	defaultRunCommand    = "devrun"
	dockerImageComponent = "dockerimage"
)

// IsDevfileSupported checks if devfile v1 is supported
func IsDevfileSupported(devfile types.Devfile) bool {

	hasSupportedContainer := false
	hasRunCommand := false

	for _, component := range devfile.Components {
		if strings.Contains(component.Type, dockerImageComponent) && component.Alias != "" {
			hasSupportedContainer = true
			break
		}
	}

	for _, command := range devfile.Commands {
		if strings.Contains(strings.ToLower(command.Name), string(defaultRunCommand)) {
			hasRunCommand = true
			break
		}
	}

	return hasSupportedContainer && hasRunCommand
}

// GetDevfile reads the devfile from the path and returns the devfile struct
func GetDevfile(devfilePath string) (types.Devfile, error) {
	var devfile types.Devfile
	devFilePath, err := ioutil.ReadFile(devfilePath)
	if err != nil {
		return types.Devfile{}, err
	}
	err = yaml.Unmarshal(devFilePath, &devfile)
	if err != nil {
		return types.Devfile{}, err
	}

	return devfile, nil
}

// GetMeta reads the meta.yaml and returns the meta struct
func GetMeta(metafilePath string) (types.Meta, error) {
	var meta types.Meta
	metaFilePath, err := ioutil.ReadFile(metafilePath)
	if err != nil {
		return types.Meta{}, err
	}
	err = yaml.Unmarshal(metaFilePath, &meta)
	if err != nil {
		return types.Meta{}, err
	}

	return meta, nil
}
