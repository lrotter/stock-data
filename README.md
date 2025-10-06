# stock-data

Project for managing bash scripts and their execution results.

## Project Structure

```
stock-data/
├── scripts/        # Bash scripts for data processing
│   ├── README.md   # Scripts documentation
│   └── example.sh  # Example script
└── data/           # Script execution results (committed to repository)
    └── README.md   # Data directory documentation
```

## Usage

1. Navigate to the scripts directory:
   ```bash
   cd scripts
   ```

2. Run a script:
   ```bash
   ./example.sh
   ```

3. Check the results in the `data` directory:
   ```bash
   ls -la ../data/
   ```

## Adding New Scripts

1. Create your bash script in the `scripts` directory
2. Make it executable: `chmod +x scripts/your_script.sh`
3. Ensure it saves output to the `data` directory
4. Commit both the script and its results

## Purpose

This repository is designed to:
- Store bash scripts for stock data processing
- Track script execution results in the `data` directory
- Maintain a history of data changes through git commits