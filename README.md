# early-sleep-eye-tracking-analysis
Detection of early sleep spans in eye-tracking data

# Setting things up
This project must be setup as the following working tree:

```bash
.
├── data
│   └── project-data-source -> /<your-data-source-folder-or-drive>/
├── output
└── src
    ├── 0-info
    ├── 1-load
    ├── 2-clean
    ├── 5-EDA
    └── 6-model
```

## Linking the main data folder
The ```project-data-source``` folder must be a **symbolic link** to the main project data folder. This folder possible contain sensitive data and must not be uploaded to github. An exception has already been added to the ```.gitignore``` file ignoring all files inside the ```data``` path.

### Creating a symbolic link
Create a symbolic link between the ```data``` folder and the real data folder path in your disk is the best way to attach all data files to this project.

#### Linux & Mac OS:
Using bash:

```bash
ln -s /your/data/folder/path/here ./data/project_data_source
```
#### Windows:
Using CMD

```CMD
mklink /D "C:\your\data\folder\here" "\data\project_data_source"
```



