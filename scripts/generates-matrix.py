import numpy as np
import sys

def generate_sparse_matrix(P, output_file="matrix.mtx"):
    M = N = 200000 * P
    nnz_per_row = 32
    total_nnz = M * nnz_per_row

    rows = []
    cols = []
    data = []

    for i in range(M):
        row_indices = np.random.choice(N, size=nnz_per_row, replace=False)
        rows.extend([i + 1] * nnz_per_row)
        cols.extend(row_indices + 1)
        data.extend(np.random.rand(nnz_per_row).tolist())

    with open(output_file, "w") as f:
        f.write("%%MatrixMarket matrix coordinate real general\n")
        f.write(f"{M} {N} {total_nnz}\n")
        for r, c, d in zip(rows, cols, data):
            f.write(f"{r} {c} {d:.6f}\n")

if __name__ == "__main__":
    P = int(input("Enter the number of processes (P): "))
    output_file = f"matrix_P{P}.mtx"
    generate_sparse_matrix(P, output_file)
    print(f"Matrix generated and saved to {output_file}")
