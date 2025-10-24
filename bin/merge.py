#!/usr/bin/env python3
import argparse
import pandas as pd
from pathlib import Path

def main():
    parser = argparse.ArgumentParser(description="Merge VERSE exon count files into a counts matrix")
    parser.add_argument('-i', '--input', required=True, nargs='+', help="List of VERSE exon count files")
    parser.add_argument('-o', '--output', required=True, help="Output CSV counts matrix file")
    args = parser.parse_args()

    dfs = []
    for file_path in args.input:
        f = Path(file_path)
        df = pd.read_csv(f, sep="\t", index_col=0, header=None, names=['gene', f.stem])
        dfs.append(df)

    merged = pd.concat(dfs, axis=1)
    merged.to_csv(args.output)

if __name__ == "__main__":
    main()