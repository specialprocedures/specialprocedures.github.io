# Patara - Camera Focus Bracketing Tool

A Python tool for automated focus bracketing with DSLR cameras using gPhoto2.

## Features

- Automated focus bracketing with configurable step sizes
- Support for multiple camera types (Nikon, Sony, Canon)
- Progress tracking with tqdm
- Automatic image download from camera
- Configurable stabilization time to reduce vibration

## Requirements

- Python 3.6+
- gPhoto2 library
- Compatible DSLR camera connected via USB

## Installation

```bash
pip install -r requirements.txt
```

## Usage

```bash
python brackets.py -o /path/to/output -n 50 -s 10 --stabilization_time 60
```

### Options

- `-o, --out-dir`: Directory to save captured images (required)
- `-n, --images`: Number of images to capture (default: 100)
- `-s, --focus_drive_step`: Focus step size between shots (default: 5)
- `--stabilization_time`: Waiting time before starting capture in seconds (default: 300)

## Supported Cameras

- Nikon DSLRs (D850, etc.)
- Sony E-mount cameras (A7C, etc.)
- Canon DSLRs (basic support)

The tool automatically detects camera type and configures appropriate settings.