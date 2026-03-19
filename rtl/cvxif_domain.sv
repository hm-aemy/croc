// Copyright 2026 HM University of Applied Sciences Munich.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Authors:
// - Stefan Wallentowitz <stefan.wallentowitz@hm.edu>
//
// This module is the placeholder for a CV-X-IF co-processor attached to CVE2.
// The Core-V Extension Interface (CV-X-IF) allows custom accelerators to receive
// offloaded instructions from the core, read operands, and write back results.
//
// Interface channels:
//   Issue   - core presents an instruction; accelerator decides whether to accept it
//   Register- core forwards register-file operands for an accepted instruction
//   Commit  - core signals whether an accepted instruction should execute or be killed
//   Result  - accelerator returns the write-back result to the core
//
// This stub rejects all offloaded instructions (x_issue_resp_o.accept = 0) and
// never produces results. Replace the body with a real accelerator implementation.

module cvxif_domain (
  input  logic clk_i,
  input  logic rst_ni,

  // Issue channel (core -> accelerator)
  input  logic                    x_issue_valid_i,
  output logic                    x_issue_ready_o,
  input  cve2_pkg::x_issue_req_t  x_issue_req_i,
  output cve2_pkg::x_issue_resp_t x_issue_resp_o,

  // Register channel (core -> accelerator)
  input  cve2_pkg::x_register_t   x_register_i,

  // Commit channel (core -> accelerator)
  input  logic                    x_commit_valid_i,
  input  cve2_pkg::x_commit_t     x_commit_i,

  // Result channel (accelerator -> core)
  output logic                    x_result_valid_o,
  input  logic                    x_result_ready_i,
  output cve2_pkg::x_result_t     x_result_o
);

  // Stub: always ready to receive an issue request but never accept the instruction.
  // Replace with accelerator logic.
  assign x_issue_ready_o = 1'b1;
  assign x_issue_resp_o  = '0;   // accept = 0 -> core handles instruction itself

  // No results produced by this stub.
  assign x_result_valid_o = 1'b0;
  assign x_result_o       = '0;

  // Unused inputs — kept for future implementation, suppress lint warnings.
  logic unused;
  assign unused = x_issue_valid_i
                | x_issue_req_i.id[0]
                | x_register_i.id[0]
                | x_commit_valid_i
                | x_commit_i.commit_kill
                | x_result_ready_i;

endmodule
