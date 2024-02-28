#quantify with salmon

#snakemake --cores 6 --batch all=1/3 --use-conda -n

DATASETS = {"RAW_sh1_GIV_LPS_5hr_S4",
            "RAW_sh2_GIV_LPS_5hr_S6",
            "RAW_shC_LPS_5hr_S2"}


rule all:
    input: expand("quants/{dataset}/quant.sf", dataset=DATASETS)


rule salmon_quant:
    input:
        index = "index/gencode.vM24_salmon_1.1.0",
        r1 = "fastq/{sample}_L008_R1_001.fastq.gz"
    output:
        "quants/{sample}/quant.sf"

    conda:
        "envs/environments.yaml"
    params:
        dir = "quants/{sample}"

    shell:
        "salmon quant -i {input.index} -l A -r {input.r1} -p 6 --gcBias --numGibbsSamples 20  --validateMappings -o {params.dir}"