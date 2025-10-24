#!/usr/bin/env python

#pull out gene name and gene ID

import argparse


# Command-line arguments
parser = argparse.ArgumentParser(
    description="Parse a GTF file and create a tab-delimited file of Ensembl gene IDs and gene names"
)
parser.add_argument(
    "-i", "--input", required=True, help="Input GTF file", dest="input"
)
parser.add_argument(
    "-o", "--output", required=True, help="Output tab-delimited file", dest="output"
)

args = parser.parse_args()


# Parse GTF and extract gene info
gene_dict = {}

with open(args.input, 'rt') as gtf:
    for line in gtf:
        if line.startswith("#"):
            continue  # skip header lines
        fields = line.strip().split('\t')
        if len(fields) < 9:
            continue  # skip malformed lines

        attr_field = fields[8]
        attributes = {}
        for attr in attr_field.strip().split(';'):
            attr = attr.strip()
            if attr == '':
                continue
            parts = attr.split(' ')
            if len(parts) >= 2:
                key = parts[0]
                value = parts[1].replace('"', '')
                attributes[key] = value

        if 'gene_id' in attributes and 'gene_name' in attributes:
            gene_dict[attributes['gene_id']] = attributes['gene_name']


# Write output file
with open(args.output, 'w') as out:
    out.write("gene_id\tgene_name\n")
    for gene_id, gene_name in gene_dict.items():
        out.write(f"{gene_id}\t{gene_name}\n")

print(f"Extracted {len(gene_dict)} genes to {args.output}")