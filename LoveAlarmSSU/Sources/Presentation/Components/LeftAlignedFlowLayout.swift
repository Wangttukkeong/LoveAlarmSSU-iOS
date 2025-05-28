//
//  LeftAlignedFlowLayout.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import SwiftUI

struct LeftAlignedFlowLayout: Layout {
    var xSpacing: CGFloat
    var ySpacing: CGFloat

    struct Row {
        var subviews: [LayoutSubviews.Element]
        var width: CGFloat
        var height: CGFloat
    }

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let rows = calculateRows(
            proposal: proposal,
            subviews: subviews
        )
        let width = proposal.width ?? rows.map { $0.width }.max() ?? 0
        let height = rows.reduce(0) { $0 + $1.height + ySpacing } - ySpacing

        return CGSize(width: width, height: height)
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let rows = calculateRows(
            proposal: ProposedViewSize(
                width: bounds.width,
                height: nil
            ),
            subviews: subviews
        )

        var yCoord: CGFloat = bounds.minY

        for row in rows {
            var xCoord: CGFloat = bounds.minX
            for subview in row.subviews {
                let size = subview.sizeThatFits(.unspecified)
                subview.place(
                    at: CGPoint(x: xCoord, y: yCoord),
                    proposal: ProposedViewSize(
                        width: size.width,
                        height: size.height
                    )
                )
                xCoord += size.width + xSpacing
            }
            yCoord += row.height + ySpacing
        }
    }

    private func calculateRows(
        proposal: ProposedViewSize,
        subviews: Subviews
    ) -> [Row] {
        guard let proposalWidth = proposal.width else { return [] }

        var rows: [Row] = []
        var currentRow: Row = Row(subviews: [], width: 0, height: 0)

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            let needsNewRow = !currentRow.subviews.isEmpty &&
                             currentRow.width + size.width > proposalWidth

            if needsNewRow {
                rows.append(currentRow)
                currentRow = Row(subviews: [], width: 0, height: 0)
            }

            currentRow.subviews.append(subview)
            currentRow.width += size.width + (currentRow.subviews.count > 1 ? xSpacing : 0)
            currentRow.height = max(currentRow.height, size.height)
        }

        if !currentRow.subviews.isEmpty {
            rows.append(currentRow)
        }

        return rows
    }
}
