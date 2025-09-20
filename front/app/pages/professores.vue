<template>
    <div class="min-h-screen bg-white p-6">
        <div class="max-w-7xl mx-auto">
            <div class="flex justify-between text-center mb-16">
                <h1 class="text-3xl font-light text-gray-900 mb-2">Professores</h1>
                <router-link to="/"
                    class="px-4 py-3 text-xs uppercase tracking-wide text-gray-600 border border-gray-200 hover:bg-gray-50 transition-colors">Voltar</router-link>
            </div>

            <div v-if="loading" class="flex justify-center items-center py-20">
                <div class="animate-spin rounded-full h-8 w-8 border border-gray-200 border-t-gray-900"></div>
                <span class="ml-3 text-gray-500 font-light">Carregando...</span>
            </div>

            <div v-else-if="error" class="border border-red-200 text-red-600 px-4 py-3 text-sm mb-8">
                {{ error }}
            </div>

            <div v-else>
                <div class="mb-12">
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                        <div>
                            <label class="block text-xs uppercase tracking-wide text-gray-600 mb-2">ONG</label>
                            <select v-model="filters.ong"
                                class="w-full p-3 border border-gray-200 text-sm focus:outline-none focus:border-gray-400 transition-colors">
                                <option value="">Todas</option>
                                <option v-for="ong in uniqueOngs" :key="ong" :value="ong">{{ ong }}</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-xs uppercase tracking-wide text-gray-600 mb-2">Professor</label>
                            <select v-model="filters.professor"
                                class="w-full p-3 border border-gray-200 text-sm focus:outline-none focus:border-gray-400 transition-colors">
                                <option value="">Todos</option>
                                <option v-for="professor in uniqueProfessors" :key="professor" :value="professor">{{
                                    professor }}</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-xs uppercase tracking-wide text-gray-600 mb-2">Matéria</label>
                            <select v-model="filters.materia"
                                class="w-full p-3 border border-gray-200 text-sm focus:outline-none focus:border-gray-400 transition-colors">
                                <option value="">Todas</option>
                                <option v-for="materia in uniqueMaterias" :key="materia" :value="materia">{{ materia }}
                                </option>
                            </select>
                        </div>

                        <div class="flex items-end">
                            <button @click="clearFilters"
                                class="w-full px-4 py-3 text-xs uppercase tracking-wide text-gray-600 border border-gray-200 hover:bg-gray-50 transition-colors">
                                Limpar
                            </button>
                        </div>
                    </div>
                </div>

                <div class="grid grid-cols-2 md:grid-cols-4 gap-8 mb-16">
                    <div class="text-center">
                        <div class="text-2xl font-light text-gray-900 mb-1">{{ uniqueStudents.length }}</div>
                        <div class="text-xs uppercase tracking-wide text-gray-500">Alunos</div>
                    </div>
                    <div class="text-center">
                        <div class="text-2xl font-light text-gray-900 mb-1">{{ uniqueProfessors.length }}</div>
                        <div class="text-xs uppercase tracking-wide text-gray-500">Professores</div>
                    </div>
                    <div class="text-center">
                        <div class="text-2xl font-light text-gray-900 mb-1">{{ uniqueMaterias.length }}</div>
                        <div class="text-xs uppercase tracking-wide text-gray-500">Matérias</div>
                    </div>
                    <div class="text-center">
                        <div class="text-2xl font-light text-gray-900 mb-1">{{ uniqueOngs.length }}</div>
                        <div class="text-xs uppercase tracking-wide text-gray-500">ONGs</div>
                    </div>
                </div>

                <h2 class="text-xl font-light text-gray-800 mb-6">Professores e Alunos</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 mb-16">
                    <div v-for="(item, index) in filteredData" :key="index"
                        class="border border-gray-100 hover:border-gray-200 transition-colors">
                        <div class="p-6 border-b border-gray-100">
                            <h3 class="text-lg font-light text-gray-900 mb-1">{{ item.professor }}</h3>
                            <p class="text-sm text-gray-500">{{ item.materia }}</p>
                        </div>
                        <div class="p-6 space-y-4">
                            <div>
                                <div class="text-xs uppercase tracking-wide text-gray-500 mb-1">Aluno</div>
                                <div class="text-sm text-gray-900">{{ item.aluno }}</div>
                            </div>
                            <div>
                                <div class="text-xs uppercase tracking-wide text-gray-500 mb-1">Área de Interesse</div>
                                <div class="text-sm text-gray-900">{{ item.area_interesse }}</div>
                            </div>
                            <div>
                                <div class="text-xs uppercase tracking-wide text-gray-500 mb-1">Organização</div>
                                <div class="text-sm text-gray-900">{{ item.ong }}</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div v-if="filteredData.length === 0 && dados.length === 0" class="text-center py-16">
                    <div class="text-gray-400 mb-2">—</div>
                    <div class="text-sm text-gray-500">Nenhum resultado encontrado</div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
const dados = ref([])
const loading = ref(true)
const error = ref(null)

const filters = ref({
    ong: '',
    professor: '',
    materia: ''
})

const fetchData = async () => {
    try {
        loading.value = true
        error.value = null

        const response = await fetch('http://18.118.50.3/:8080/professor')
        if (!response.ok) throw new Error(`Erro HTTP: ${response.status}`)
        dados.value = await response.json()
    } catch (err) {
        console.error('Erro ao buscar dados:', err)
        error.value = 'Não foi possível carregar os dados.'
    } finally {
        loading.value = false
    }
}

const uniqueOngs = computed(() => [...new Set(dados.value.map(i => i.ong))].sort())
const uniqueProfessors = computed(() => [...new Set(dados.value.map(i => i.professor))].sort())
const uniqueMaterias = computed(() => [...new Set(dados.value.map(i => i.materia))].sort())
const uniqueStudents = computed(() => [...new Set(dados.value.map(i => i.aluno))].sort())

const filteredData = computed(() => {
    return dados.value.filter(item => {
        return (
            (filters.value.ong === '' || item.ong === filters.value.ong) &&
            (filters.value.professor === '' || item.professor === filters.value.professor) &&
            (filters.value.materia === '' || item.materia === filters.value.materia)
        )
    })
})

const clearFilters = () => {
    filters.value = { ong: '', professor: '', materia: '' }
}

onMounted(() => {
    fetchData()
})
</script>