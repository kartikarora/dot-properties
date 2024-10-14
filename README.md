<a href="https://github.com/kartikarora/dot-properties/blob/master/.github/workflows/main.yml">![](https://github.com/kartikarora/dot-properties/actions/workflows/main.yml/badge.svg?branch=master)</a>
<a href="https://github.com/kartikarora/dot-properties/releases">![](https://img.shields.io/github/v/release/kartikarora/dot-properties)</a>

This is a GitHub action to read from or write to a `.properties` file.

**Note:** It will work for all file-types that follow the `key=value` pattern.

Forked from [christian-draeger/read-properties](https://github.com/christian-draeger/read-properties/) and modified using [christian-draeger/write-properties](https://github.com/christian-draeger/write-properties)

## Inputs

### `read-path`

The path to properties file to read.

### `read-properties`

The properties you want to read. Space separated

### `write-path`

The path to properties file to read.

### `write-properties`

The properties keys you want to write. Arrays accepted

### `write-values`

The property values you want to write (same order as the keys). Accepts an array.

## Outputs

For each provided property, one output of the same name exists. Because the names of outputs can only contain alphanumeric characters, `-` and `_`, any other character is replaced by a `-`.

## Known issues

- This action currently does not support updating existing property values.
- When writing multiple properties, the array needs to be defined using `|-` and not `|`. See example below

## Requirements

This action is Docker-based. It means **it can only execute on runners with a Linux operating system**.
See Github Actions [documentation](https://docs.github.com/en/actions/creating-actions/about-actions#docker-container-actions) for details.

## Example usage

    - name: Read single value from properties file
      id: read_property
      uses: kartikarora/dot-properties@v1
      with:
        read-path: './path/toapplication.properties'
        read-properties: 'the.key.of.a.property'
    - name: Do something with your read value
      run: echo ${{ steps.read_property.outputs.the-key-of-a-property }}
      # will print "the value of 'the.key.of.a.property'"

    - name: Read multiple value from properties file
      id: read_multiple_properties
      uses: kartikarora/dot-properties@v1
      with:
        read-path: './path/toapplication.properties'
        read-properties: 'the.key.of.a.property the.key.of.another.property'
    - name: Do something with your read values
      run: echo ${{ steps.read_multiple_properties.outputs.the-key-of-a-property }}
      # will print "the value of 'the.key.of.a.property'"

    - name: Write value to properties file
      id: write_property
      uses: kartikarora/dot-properties@v1
      with:
        write-path: './path/to/application.properties'
        write-properties: 'the.key.of.a.property'
    - name: Do something with your written value
      run: cat './path/to/application.properties'
      # will print the file contents of application.properties

    - name: Write value to properties file
      id: write_multiple_properties
      uses: kartikarora/dot-properties@v1
      with:
        write-path: './path/to/application.properties'
        write-properties: |-
          the.key.of.a.property
          the.key.of.another.property
        write-values: |-
          value of property
          value of another property
    - name: Do something with your written values
      run: cat './path/to/application.properties'
      # will print the file contents of application.properties
