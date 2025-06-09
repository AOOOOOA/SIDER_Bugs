---
layout: default
title: Experiment Results
---

# Experiment Results

Below is a summary table of our main experiment findings.

<table>
    <thead>
        <tr>
            <th>Simulator</th>
            <th>Bugs Found</th>
            <th>Critical Issues</th>
            <th>Confirmed by Devs</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>CARLA</td>
            <td>13</td>
            <td>Collisions, Off-road, Stuck</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>MetaDrive</td>
            <td>5</td>
            <td>Collision, Off-road, Stuck</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>CARLA-Apollo</td>
            <td>3</td>
            <td>Stuck, Trajectory Deviations</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>

---

## Introduction

3D driving simulators are essential tools for autonomous driving research. However, their reliability is often overlooked.  
Our project systematically evaluates simulator reliability and exposes several critical bugs.

## Key Findings

- **20 distinct simulator bugs** found across three major simulators.
- **Critical failures** include collisions, off-road events, agent stuck, and trajectory deviations.
- Some bugs have been **confirmed by original developers**.
- Certain errors **do not occur in matched real-world experiments**, showing risk of misleading ADS evaluation.

## Detailed Results

TBS
---

## Contact

Feel free to contact us on github repo for more information.
