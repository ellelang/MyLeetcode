class Solution:
    def sortedArrayToBST(self, nums: List[int]) -> TreeNode:
        def to_bst(nums,left, right):
            if left > right:
                return None

            # always choose left middle node as a root
            mid = (left + right) // 2

            # inorder traversal: left -> node -> right
            node = TreeNode(nums[mid])
            node.left = to_bst(nums,left, mid - 1)
            node.right = to_bst(nums, mid + 1, right)
            return node

        return to_bst(nums, 0, len(nums) - 1)
