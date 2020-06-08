package utils

import (
	"io/ioutil"
	"strings"

	"github.com/elsony/devfile-registry/tools/types"
	"github.com/ghodss/yaml"
)

const (
	defaultRunCommand    = "devrun"
	dockerImageComponent = "dockerimage"
)

// IsDevfileSupported checks if devfile v1 is supported
func IsDevfileSupported(devfile types.Devfile) bool {

	hasDockerImage := false
	hasAlias := false
	hasRunCommand := false

	for _, component := range devfile.Components {
		if hasDockerImage && hasAlias {
			break
		}

		if !hasDockerImage {
			hasDockerImage = strings.Contains(component.Type, dockerImageComponent)
		}

		if !hasAlias {
			hasAlias = len(component.Alias) > 0
		}
	}

	for _, command := range devfile.Commands {
		if hasRunCommand {
			break
		}

		if !hasRunCommand {
			hasRunCommand = strings.Contains(strings.ToLower(command.Name), string(defaultRunCommand))
		}
	}

	if hasDockerImage && hasAlias && hasRunCommand {
		return true
	}

	return false
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
