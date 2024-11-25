import { useSession } from "next-auth/react"
import { redirect } from "next/navigation"

export function useAuth() {
  const { data: session, status } = useSession()
  
  if (status === "loading") {
    return null
  }

  if (!session) {
    redirect("/login")
  }

  return session
} 