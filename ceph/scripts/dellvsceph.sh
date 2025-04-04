#!/bin/bash

echo "Identificando volumes físicos (PVs) do Ceph..."
pvs_output=$(pvs --noheadings -o pv_name,vg_name | grep ceph)

if [[ -z "$pvs_output" ]]; then
    echo "Nenhum volume Ceph encontrado."
    exit 1
fi

while read -r pv vg; do
    if [[ -n "$vg" ]]; then
        echo "Removendo Logical Volumes (LVs) do grupo $vg..."
        lvremove -f "$vg"

        echo "Removendo Volume Group (VG) $vg..."
        vgremove -f "$vg"
    fi

    echo "Removendo Physical Volume (PV) $pv..."
    pvremove -f "$pv"
done <<< "$pvs_output"

echo "Todos os volumes Ceph foram removidos!"
