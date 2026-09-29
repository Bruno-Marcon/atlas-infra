output "addons_instalados" {
  description = "Add-ons efetivamente criados (vazio quando habilitar = false)"
  value       = [for a in aws_eks_addon.this : a.addon_name]
}
